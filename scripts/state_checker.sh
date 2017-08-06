add_text_string="Hello World!"

function move_to_c_club(){
        cd /home/c_club
}

if [ "$tour_state" == "start" ]; then    
        current_state="start"

        if [ "$PWD" == /home/c_club ]; then
          export tour_state="add_file"
          export number_of_trials=0
        else
          echo "Go to this /home/c_club"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: cd /home/c_club"
          move_to_c_club
          export tour_state="add_file"
          export number_of_trials=0
        fi
fi

if [ "$tour_state" == "add_file" ]; then
        current_state="add_file"

        if [ -e /home/c_club/abc ]; then
          export tour_state="add_text"
          export number_of_trials=0
        else
          echo "You need to add a file named abc in the current folder"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: touch abc"
          touch /home/c_club/abc
          export tour_state="add_text"
          export number_of_trials=0
        fi
fi

if [ "$tour_state" == "add_text" ]; then
        current_state="add_text"
        
        if [[ "$( cat /home/c_club/abc )" == $add_text_string ]]; then
          export tour_state="finished"
          export number_of_trials=0
        else
          echo "In file abc write: Hello World!"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: nano abc. Then write Hello World! "
          echo "Hello World!" >>  /home/c_club/abc
          export tour_state="finished"
          export number_of_trials=0
        fi
fi

if [ "$tour_state" == "finished" ]; then
        echo "Nice job! You have completed this exercise"
fi
