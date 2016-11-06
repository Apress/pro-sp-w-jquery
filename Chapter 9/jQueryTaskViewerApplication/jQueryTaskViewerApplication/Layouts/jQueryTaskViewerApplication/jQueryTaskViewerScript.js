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

    $('#addTaskButton').click(function () {
        // Get the Users title
        var title = $('#newTaskTitle').val();

        // If no value is set then show alert and set focus
        if (title == '') {
            alert('Please enter a value');
            $('#newTaskTitle').focus();

        } else {
            AddNewTask(title);
        }
    });

    $("#newTaskTitle").keyup(function (event) {
        switch (event.keyCode) {
            // Handle the Enter button to call button click                        
            case 13: $('#addTaskButton').click();
                break;
            // Handle the ESC key press to clear value                        
            case 27: $(this).val('');
                break;
        }
    });

    $('.deleteButton').on("click", function () {
        $(this).siblings('.confirmDelete').show();
        $(this).hide();
    });

    $('.noDeleteButton').on("click", function () {
        $(this).parent('.confirmDelete').hide();
        $(this).parent().siblings('.deleteButton').show();
    });

    $('.yesDeleteButton').on("click", function () {
        deleteTask(this);
    });

    $('.task').on("dblclick", function () {

        // Makes it easier to see what
        // the code is dealing with
        var taskElement = $(this);

        // Hide the task details
        taskElement.children('div.taskDetailDiv').hide();

        // Show the edit elements
        taskElement.children('div.editDiv').show();

        // Get the title from the Task Title Paragraph
        var title = taskElement.find('p.taskTitle').text();

        // Get the description from the Task Title Paragraph
        var description = taskElement.find('p.taskDescription').text();

        // Set the text of the editable Text input to the title
        taskElement.find('input.editTaskTitle').val(title);

        // Set the text of the editable Text Area input to the description
        taskElement.find('textarea.editTaskDescription').text(description);
    });


    $('.editTaskSaveButton').on("click", function () {
        // Update task
        updateTask(this);
    });

    $('.editTaskCancelButton').on("click", function () {
        // Get the task by traversing the tree to the li element
        var taskListItemElement = $(this).parents("li:first");

        // Hide the edit div
        taskListItemElement.children('div.editDiv').hide();

        // Show the default details div
        taskListItemElement.children('div.taskDetailDiv').show();
    });

    // DRAG AND DROP SECTION

    // Add droppable to the 'Not Started' list
    // Will only accept items from 'In Progress'
    $('#notStartedTasksDiv>ul').droppable({
        activeClass: "task-active",
        hoverClass: "task-hover",
        accept: function (d) {
            // Check if item is coming from valid state 
            // if it is then accept to drop
            if (d.data('status') == "In Progress") {
                return true;
            }
        },
        drop: function (ev, ui) {
            // Get the element being dragged
            var taskItem = $(ui.draggable);
            // Update the item
            ChangeStatus(taskItem, direction.Left);
        }
    });

    // Add droppable to the 'In Progress' list
    // Will accept items which are not 'In Progress'
    $('#inProgressTasksDiv>ul').droppable({
        activeClass: "task-active",
        hoverClass: "task-hover",
        accept: function (d) {
            if (d.data('status') != "In Progress") {
                return true;
            }
        },
        drop: function (ev, ui) {
            var taskItem = $(ui.draggable);
            if (taskItem.data('status') == "Completed") {
                ChangeStatus(taskItem, direction.Left);
            } else {
                ChangeStatus(taskItem, direction.Right);
            }
        }
    });

    // Add droppable to the 'Completed' list
    // Will only accept items which are 'In Progress'
    $('#completedTasksDiv>ul').droppable({
        activeClass: "task-active",
        hoverClass: "task-hover",
        accept: function (d) {
            if (d.data('status') == "In Progress") {
                return true;
            }
        },
        drop: function (ev, ui) {
            var taskItem = $(ui.draggable);
            ChangeStatus(taskItem, direction.Right);
        }
    });

    // END DRAG AND DROP SECTION


});

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

function AddNewTask(taskName) {
    // Get the current context
    var context = new SP.ClientContext.get_current();

    // Load the web object   
    var web = context.get_web();

    //Get the list
    var list = web.get_lists().getByTitle(taskListName);

    // create the ListItemInformational object
    var listItemInfo = new SP.ListItemCreationInformation();

    // add the item to the list
    var listItem = list.addItem(listItemInfo);

    // Assign Values for fields
    listItem.set_item('Title', taskName);

    // Apply changes to Item
    listItem.update();

    //Make a query call to execute the above statements
    context.executeQueryAsync(AddTaskSuccess, AddTaskFail);
}

function AddTaskSuccess() {
    // Task has been added so refresh
    GetTasks();

    // Reset the input box
    $('#newTaskTitle').val('');

    // Add focus to carry on adding
    $('#newTaskTitle').focus();
}

function AddTaskFail(sender, args) {
    alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}


function deleteTask(taskElement) {

    // Get the parent list item of the task
    var taskListItemElement = $(taskElement).parents("li:first");

    // Get the current context
    var context = new SP.ClientContext.get_current();

    // Load the web object   
    var web = context.get_web();

    //Get the list
    var list = web.get_lists().getByTitle(taskListName);

    var taskId = taskListItemElement.data('taskID');

    // Get Item to delete by If from the list
    var itemToDelete = list.getItemById(taskId);

    // Add Delete method to the query
    itemToDelete.deleteObject();

    // Execute the query to perform the deletion
    context.executeQueryAsync(DeleteTaskSuccess, DeleteTaskFail);
}

function DeleteTaskSuccess() {
    GetTasks();
}

function DeleteTaskFail(sender, args) {
    alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}

var tasks;
var taskListName = "Tasks";

function ChangeStatus(taskElement, moveDirection) {

    taskElement = $(taskElement);
    var taskListItemElement;

    if (taskElement.is('li')) {
        taskListItemElement = taskElement;
    } else {
        taskListItemElement = $(taskElement).parents("li:first");
    }

    // Get the new status based on the existing status
    // and the direction it is moving
    var updatedStatus = GetNewStatus(taskListItemElement, moveDirection);

    // Return if invalid new status
    if (updatedStatus == null) {
        return;
    }

    // Update the SharePoint Task Listitem with the new status
    updateTaskStatus(taskListItemElement.data('taskID'), updatedStatus);

    // Get the tasks again from the server
    GetTasks();
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

    itemTemplate.draggable(
                {
                    helper: 'clone'
                });

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

function GetTasksUsingWebService(taskListName) {

    // Get relative url of the webservice and task list name
    // taskListName is a parameter passed into the function
    var listUrl = "/_vti_bin/ListData.svc/" + taskListName;

    // Call the URL to get the JSON from the List
    $.getJSON(listUrl, function (data) {

        // Iterate through the results to get the tasks
        $.each(data.d.results, function (i, result) {

            // Get the list which to add the tasks details
            var taskList = GetTaskListElementByTaskStatus(result.StatusValue);

            // If there is a suitable task list then add task element
            if (taskList != null) {
                addTaskToList(taskList, result.Id, result.Title + ' - WS', result.Description);
            }

        });
    });
}

