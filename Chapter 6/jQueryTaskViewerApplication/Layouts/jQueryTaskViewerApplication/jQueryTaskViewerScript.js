// Create object to make it easy to
// choose direction
var direction = {
    Left: "Left",
    Right: "Right"
};

$(document).ready(function () {
    // Wait until SP.JS has loaded before calling GetTasks
    ExecuteOrDelayUntilScriptLoaded(GetTasks, "sp.js");

    $('.moveLeftButton').on("click", (function () {
        // Change status to the left
        ChangeStatus(this, direction.Left);
    }));

    $('.moveRightButton').on("click", (function () {
        // Change status to the right
        ChangeStatus(this, direction.Right);
    }));

});

var tasks;
var taskListName = "Tasks";

function GetTasks() {

    // Get the current context
    var context = new SP.ClientContext.get_current();

    // Load the web object   
    var web = context.get_web();

    //Get the list
    var list = web.get_lists().getByTitle(taskListName);

    // Get all the items in the list
    tasks = list.getItems('');

    // Load the web in the context and retrieve only selected columns to improve performance                           
    context.load(tasks, 'Include(ID,Title,Body,Status)');

    //Make a query call to execute the above statements
    context.executeQueryAsync(OnGetTasksSucceeded, OnGetTasksFailed);

}

function OnGetTasksSucceeded() {
    // Remove all current tasks
    $('.taskDiv>ul').empty();

    // Get the collection
    var taskCollection = tasks.getEnumerator();

    // Iterate through tasks
    while (taskCollection.moveNext()) {

        // Load the current task in iteration
        var task = taskCollection.get_current();

        // Get the list which to add the tasks details
        var taskList = GetTaskListElementByTaskStatus(task.get_item('Status'));

        // If there is a suitable task list then add task element
        if (taskList != null) {
            addTaskToList(taskList, task.get_item('ID'), task.get_item('Title'), task.get_item('Body'), task.get_item('Status'));
        }
    }
}

// Error handler
function OnGetTasksFailed(sender, args) {
    alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}

function GetTaskListElementByTaskStatus(status) {

    var taskList;

    // Switch on the status value to make sure it gets added to
    // the correct list
    switch (status) {
        case "Not Started": taskList = $('#notStartedTasksDiv>ul');
            break;
        case "In Progress": taskList = $('#inProgressTasksDiv>ul');
            break;
        case "Completed": taskList = $('#completedTasksDiv>ul');
            break;
        default:
            // Code only supports Not Started, In Progress
            // and Completed tasks
            taskList = null;
    }

    return taskList;

}

function addTaskToList(list, id, title, description, status) {
    // Create a copy of the <li> template
    var itemTemplate = $('#TemplateListItem').clone();

    // Remove the unnecessary id attribute
    itemTemplate.attr('id', null);

    // Set the title to the task title
    itemTemplate.find('.taskTitle').text(title);

    // Set the description to the task description
    itemTemplate.find('.taskDescription').html(description);

    itemTemplate.data('status', status);
    itemTemplate.data('taskID', id);

    // Only show possible direction of movement
    switch (status) {
        case "Not Started": itemTemplate.find('.moveLeftButton').hide();
            break;
        case "Completed": itemTemplate.find('.moveRightButton').hide();
            break;
    }

    // Add Task Element created from template
    list.append(itemTemplate);
}

function updateTask(taskElement) {
    // Get the parent list item of the task
    var taskListItemElement = $(taskElement).parents("li:first");

    // Get the updated text
    var taskTitleElement = taskListItemElement.find('input.editTaskTitle');
    var updatedTitle = taskTitleElement.val();

    // If no title is set then show alert and set focus
    if (updatedTitle == '') {
        alert('Please enter a value for the task title');
        taskTitleElement.focus();
        return;
    }

    // Read the description form the text area
    var updatedDescription = taskListItemElement.find('textarea.editTaskDescription').text();

    // Get the current context
    var context = new SP.ClientContext.get_current();

    // Load the web object   
    var web = context.get_web();

    //Get the list
    var list = web.get_lists().getByTitle(taskListName);

    var taskId = taskListItemElement.data('taskID');

    // Get Item to update by Id from the list
    var listItem = list.getItemById(taskId);

    //Set the new property value
    listItem.set_item('Title', updatedTitle);
    listItem.set_item('Body', updatedDescription);

    // Call the update method to commit the change
    listItem.update();

    GetTasks();
}

function ChangeStatus(taskElement, moveDirection) {
    // Get the parent list item of the task
    var taskListItemElement = $(taskElement).parents("li:first");

    // Get the new status based on the existing status
    // and the direction it is moving
    var updatedStatus = GetNewStatus(taskListItemElement, moveDirection);

    // Return if invalid new status
    if (updatedStatus == null) {
        return;
    }
    // Update the SharePoint Task List item with the new status
    updateTaskStatus(taskListItemElement.data('taskId'), updatedStatus);

    // Get the tasks again from the server
    GetTasks();
}

function updateTaskStatus(id, status) {

    // Get the current context
    var context = new SP.ClientContext.get_current();

    // Load the web object   
    var web = context.get_web();

    //Get the list
    var list = web.get_lists().getByTitle(taskListName);

    //Get the list item to update
    var listItem = list.getItemById(id);

    //Set the new property value
    listItem.set_item('Status', status);

    // Call the update method to commit the change
    listItem.update();
}

function GetNewStatus(element, moveDirection) {

    // Retrieve the Status from the elements data object
    var currentStatus = element.data("status");

    var newStatus = null;

    // Get the new Status depending on the direction request
    // i.e Moving Left or Right
    if (moveDirection == direction.Left) {
        newStatus = GetLeftStatus(currentStatus);
    }
    else if (moveDirection == direction.Right) {
        newStatus = GetRightStatus(currentStatus);
    };

    return newStatus;
}

function GetLeftStatus(currentStatus) {
    var newStatus = null;
    switch (currentStatus) {
        case "In Progress": newStatus = "Not Started";
            break;
        case "Completed": newStatus = "In Progress";
            break;
    }
    return newStatus;
}

function GetRightStatus(currentStatus) {
    var newStatus = null;
    switch (currentStatus) {
        case "Not Started": newStatus = "In Progress";
            break;
        case "In Progress": newStatus = "Completed";
            break;
    }
    return newStatus;
}