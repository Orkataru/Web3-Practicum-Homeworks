// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract todolist{

    struct Task{       // Initializes the Task struct

    bool Completed;     // true if the task is completed, false if not
    string TaskName;    // Name of the task
    uint deployDate;    // Time of deployment, will be initialized with the "create" function to the current block time
    bool isTimeLimit;   // true if the user wants to set a deadline for the task, false if not
    uint timelimit;     // time limit in seconds
    bool isontime;      // true if the task is completed on time, false if not

    }


    Task[] public todos;           // Creates an array of Task structs 


    function Create(string calldata _name) external {       // / call this function if you don't want to specify a deadline
        
        todos.push(               // Pushes a Task struct to the todos list with the members specified below
        Task(
            {

        TaskName : _name,
        Completed : false,
        deployDate: block.timestamp,
        isTimeLimit: false,
        timelimit: 0,
        isontime: false


    }
    ));

    }

    function Create(string calldata _name, uint256 _deadlineH) external {       // call this function if you want to specify a deadline
        
        todos.push(               // Pushes a Task struct to the todos list with the members specified below
        Task(
            {

        TaskName : _name,
        Completed : false,
        deployDate: block.timestamp,
        isTimeLimit: true,
        timelimit: _deadlineH,
        isontime: false

    }
    ));

    }

    function toggleCompleted(uint _index) external {   
        
        todos[_index].Completed = !todos[_index].Completed;     // Changes the Completed status
        Task memory task = todos[_index];

        if (task.isTimeLimit){
        uint256 timeElapsed = block.timestamp - task.deployDate;
        
        todos[_index].isontime = timeElapsed > task.timelimit || !todos[_index].Completed ?   false : true;       // if the task is completed on time, sets isontime=true; if not, false.

    }}


    function get(uint _index) external view returns(string memory, bool, uint256, bool) {  // Returns the TaskName, Completed, timeElapsed (in seconds) and isontime values of the task at the specified index
       
        Task memory task = todos[_index];
        uint256 timeElapsed = block.timestamp - task.deployDate;

        return (task.TaskName, task.Completed, timeElapsed, task.isontime);

    }


}