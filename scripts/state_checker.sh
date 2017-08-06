add_text_string="Hello World!"

if [ "$tour_state" == "start" ]; then    
        if [ "$PWD" == /home/c_club ]; then
          export tour_state="add_file"
        else
          echo "Go to this /home/c_club"
        fi
fi
if [ "$tour_state" == "add_file" ]; then
        if [ -e /home/c_club/abc ]; then
          export tour_state="add_text"
        else
          echo "You need to add a file named abc in the current folder"
        fi
fi
if [ "$tour_state" == "add_text" ]; then
        if [[ "$( cat /home/c_club/abc )" == $add_text_string ]]; then
          export tour_state="finished"
        else
          echo "In file abc write: Hello World!"
        fi
fi
if [ "$tour_state" == "finished" ]; then
        echo "Nice job! You have completed this exercise"
fi
