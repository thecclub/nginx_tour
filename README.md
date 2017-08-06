# nginx_tour

* When the user logs in display a greeting -- done
* Ask the user to go into a certain folder -- done
* Ask user to change a file -- done
* Check if file changed is correctly configured

Note
* After each command user runs check the state -- done
* If state is the intended one, great, move to next state, otherwise ask the user try again -- done
* Note the number of trials and state in env variables
* If number of trials > 3, run the command tell user what had to be done, move to next state
* Need to fire a script after each command by user, to check the state  --done
* Use file system to store env variables. In .project folder. File `status` should contain status, file `number_of_tries` should contain number of tries for that particular state
