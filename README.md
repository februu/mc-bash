# mc-bash 🛠️

### Bash script to automatically restart & backup your server

This simple script takes care of your minecraft server restarts. It also creates backup of your world by zipping world, world_nether and world_the_end directories and putting them in backup folder. What's more, it deletes the backup files if they are older than 7 days. In version 1.1 I also added [Aikar's flags](https://docs.papermc.io/paper/aikars-flags) which make your server's performance a little bit better.

Check out my other repo where I post other resources for minecraft & minecraft servers like scripts, stash texture packs and Dockerfiles for running servers in containers. You can visit it [here](https://github.com/februu/minecraft-resources). 

### Prerequisites

1. Put _run.sh_ in your server directory.
2. Use `sudo chmod +x run.sh` to allow the script to be executed.
3. Make sure you have **zip** and **tmux** installed. (You can use also use **screen** but I like **tmux** better). If not, use `sudo apt install -y zip tmux`.
4. Type `crontab -e`. This will bring up text editor with your cronjob tasks. At the end of the file add the line that will stop (restart) your server. The command is `tmux send -t minecraft "stop" Enter`. You can use sites like [https://crontab-generator.org/](https://crontab-generator.org/) to generate cronjob tasks that run at specific times for you. Your file should look similar to this:

```bash
# This line stops (and restarts) the server every day at midnight.
0 0 * * * tmux send -t minecraft "stop" Enter
# This line sends a warning 5 minutes before server restart
55 23 * * * tmux send -t minecraft "say Server restart in 5 minutes..." Enter
```

5. Save the file. You are now ready to use the script.

### Usage

1. Create new tmux session by executing `tmux new -s minecraft`. Use the same name you used in your cronjob task.
2. Now run the script by entering `./run.sh <server file> <max memory> <days to delete backup>`. Example: `./run.sh server.jar 4G 7`. You should see the server beggining to load.
3. Press <kbd>Ctrl</kbd> + <kbd>B</kbd>. Then press <kbd>D</kbd> to detach from session.

That's it. Now everytime your server goes down by `/stop` command or by some error, it will be automatically restarted and a new backup file will be created.
If you want to attach to the session again to execute some minecraft commands, type `tmux attach -t minecraft`. If you want to kill the server completely, make sure you are detached from the session and execute `tmux kill-session -t minecraft`.