state="$tour_state"
case "$state" in 
"start")       
echo "Go to this /home/c_club"
if [ "$PWD" = /home/c_club ] then;
  export state="add_file"
`# add else case`
fi
;;
"add_file") 
echo "You need to add a file named abc in the current folder"
if [ -e /home/c_club/abc ]; then
  export state="add_text"
else
  echo "File abc was not correctly added"
fi
;;
"done") 
echo "done"
break
;;
*)
echo "invalid state \"$state\""
break
;;
esac