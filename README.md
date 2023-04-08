# mc-bash 🛠️

### Bash script to automatically restart & backup your server.

This simple script takes care of your minecraft server restarts. It also creates backup of your world by zipping world, world_nether and world_the_end directories and putting them in backup folder. What's more, it deletes the backup files if they are older than 7 days.

### Prerequisites

1. Put _server.sh_ in your server directory.
2. Open _server.sh_ and edit **Settings** section. Save and close the file.
3. Use `sudo chmod +x server.sh` to allow the script to be executed.
4. Make sure you have **zip** and **tmux** installed. (You can use also use **screen** but I like tmux better). If not, use `sudo apt install zip` and `sudo apt install tmux`.
5. Type `mkdir backup`. This will create new directory called _backup_. All world backups will be stored there.
6. Type `crontab -e`. This will bring up text editor with your cronjob tasks. At the end of the file add the line that will stop (restart) your server. The command is `tmux send -t minecraft "stop" Enter`. You can use sites like [https://crontab-generator.org/](https://crontab-generator.org/) to generate cronjob tasks for you. Your file should look similar to this:

```bash
# This line stops (and restarts) the server every day at midnight.
0 0 * * * tmux send -t minecraft "stop" Enter
# This line sends a warning 5 minutes before server restart
55 23 * * * tmux send -t minecraft "say Server restart in 5 minutes..." Enter
```

7. Save the file. You are now ready to use the script.

### Usage

1. Create new tmux session by executing `tmux new -s minecraft`.
2. Now run the script by entering `./server.sh`. You should see the server beggining to load.
3. Press <kbd>Ctrl</kbd> + <kbd>B</kbd>. Then press <kbd>D</kbd> to detach from session.

That's it. Now everytime your server goes down by `/stop` command or by some error, it will be automatically restarted and a new backup file will be created.
If you want to attach to the session again to execute some minecraft commands, type `tmux attach -t minecraft`. If you want to kill the server completely, just execute `tmux kill-session -t minecraft`.
