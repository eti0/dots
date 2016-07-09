function fish_prompt
	test $SSH_TTY; and printf (set_color red)(whoami)(set_color red)'@'(set_color red)(hostname)' '

    test $USER = 'root'; and echo (set_color red)"#"

    # Main
	echo -n (set_color white)(prompt_pwd) (set_color white)'> '
end
