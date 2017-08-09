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

        if ! [ -d /home/c_club/abc ] && [ -e /home/c_club/abc ]; then
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
          export tour_state="install_nginx"
          export number_of_trials=0
        else
          echo "In file abc write: Hello World!"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: nano abc. Then write Hello World! "
          echo "Hello World!" >>  /home/c_club/abc
          export tour_state="install_nginx"
          export number_of_trials=0
        fi
fi

if [ "$tour_state" == "install_nginx" ]; then 
        current_state="install_nginx"

        if [ -x /usr/sbin/nginx ]; then
          export tour_state="stop_nginx"
          export number_of_trials=0
          service nginx start
        else
          echo "Install Nginx"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: apt-get install -y nginx"
          apt-get install -y nginx
          service nginx start
          export tour_state="stop_nginx"
          export number_of_trials=0
        fi
fi

if [ "$tour_state" ==  "stop_nginx" ]; then
        current_state="stop_nginx"
        service=nginx

        if (( $(ps -ef | grep -v grep | grep $service | wc -l) == 0 ))
        then
          export tour_state="start_nginx"
          export number_of_trials=0
        else
          echo "Stop the Nginx service"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: service nginx stop"
          service nginx stop
          export tour_state="start_nginx"
          export number_of_trials=0
        fi
fi

if [ "$tour_state" ==  "start_nginx" ]; then
        current_state="start_nginx"
        service=nginx

        if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
        then
          export tour_state="finished"
          export number_of_trials=0
        else
          echo "Start the Nginx service"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: service nginx stop"
          service nginx stop
          export tour_state="finished"
          export number_of_trials=0
        fi
fi


if [ "$tour_state" == "finished" ]; then
        echo "Nice job! You have completed this exercise"
fi
