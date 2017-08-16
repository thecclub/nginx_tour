add_text_string="Hello World!"

function move_to_c_club(){
        cd /home/c_club
}

function change_state(){
        export tour_state="$1"
        export number_of_trials=0
}

function print_task() {
        RED='\033[0;31m'
        RESET='\033[0m'
        
        echo -e "${RED} $1 ${RESET}"
}

function print_help() {
        GREEN='\033[0;32m'
        RESET='\033[0m'

        echo -e "${GREEN} $1 ${RESET}"
}

if [ "$tour_state" == "start" ]; then    
        current_state="start"

        if [ "$PWD" == /home/c_club ]; then
          change_state "add_file"
        else
          print_task "Go to this /home/c_club"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          print_help "You had to do: cd /home/c_club"
          move_to_c_club

          change_state "add_file"
        fi
fi

if [ "$tour_state" == "add_file" ]; then
        current_state="add_file"

        if ! [ -d /home/c_club/abc ] && [ -e /home/c_club/abc ]; then
          change_state "add_text"
        else
          print_task "You need to add a file named abc in the current folder"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          echo "You had to do: touch abc"
          print_help /home/c_club/abc

          change_state "add_text"
        fi
fi

if [ "$tour_state" == "add_text" ]; then
        current_state="add_text"
        
        if [[ "$( cat /home/c_club/abc )" == $add_text_string ]]; then
          change_state "install_nginx"
        else
          print_task "In file abc write: Hello World!"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          print_help "You had to do: nano abc. Then write Hello World! "
          echo "Hello World!" >>  /home/c_club/abc
          change_state "install_nginx"
        fi
fi

if [ "$tour_state" == "install_nginx" ]; then 
        current_state="install_nginx"

        if [ -x /usr/sbin/nginx ]; then
          change_state "go_to_nginx_folder"
          service nginx start
        else
          print_task "Install Nginx"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          print_help "You had to do: apt-get install -y nginx"
          apt-get install -y nginx
          service nginx start
          change_state "go_to_nginx_folder"
        fi
fi

if [ "$tour_state" == "go_to_nginx_folder" ]; then
        current_state="go_to_nginx_folder"
        destination=/var/www/html

        if [ "$PWD" == "$destination" ]; then
          change_state "stop_nginx"
        else
          print_task "Go to this $destination"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          print_help "You had to do: cd $destination"
          move_to_c_club

          change_state "stop_nginx"
        fi
fi



if [ "$tour_state" ==  "stop_nginx" ]; then
        current_state="stop_nginx"
        service=nginx

        if (( $(ps -ef | grep -v grep | grep $service | wc -l) == 0 ))
        then
          change_state "start_nginx"
        else
          print_task "Stop the Nginx service"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          print_help "You had to do: service nginx stop"
          service nginx stop
          change_state "start_nginx"
        fi
fi

if [ "$tour_state" ==  "start_nginx" ]; then
        current_state="start_nginx"
        service=nginx

        if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
        then
          change_state "finished"
        else
          print_task "Start the Nginx service"
          number_of_trials=$((number_of_trials+ 1))
        fi

        if [ "$tour_state" == "$current_state" ] && [ "$number_of_trials" -gt 3 ]; then
          print_help "You had to do: service nginx stop"
          service nginx stop

          change_state "finished"
        fi
fi


if [ "$tour_state" == "finished" ]; then
        echo "Nice job! You have completed this exercise"
fi
