alias dcrun='sudo docker compose --profile all -f $HOME/docker/docker-compose.yml'

# DOCKER - All Docker commands start with "d" AND Docker Compose commands start with "dc"
alias dstop='sudo docker stop $(sudo docker ps -a -q)' # usage: dstop container_name
alias dstopall='sudo docker stop $(sudo docker ps -aq)' # stop all containers
alias drm='sudo docker rm $(sudo docker ps -a -q)' # usage: drm container_name
alias dprunevol='sudo docker volume prune' # remove unused volumes
alias dprunesys='sudo docker system prune -a' # remove unsed docker data
alias ddelimages='sudo docker rmi $(sudo docker images -q)' # remove unused docker images
alias derase='dstopcont ; drmcont ; ddelimages ; dvolprune ; dsysprune' # WARNING: removes everything! 
alias dprune='ddelimages ; dprunevol ; dprunesys' # remove unused data, volumes, and images (perfect for safe clean up)
alias dexec='sudo docker exec -ti' # usage: dexec container_name (to access container terminal)
alias dps='sudo docker ps -a' # running docker processes
alias dpss='sudo docker ps -a --format "table {{.Names}}\t{{.State}}\t{{.Status}}\t{{.Image}}" | (sed -u 1q; sort)' # running docker processes as nicer table
alias ddf='sudo docker system df' # docker data usage (/var/lib/docker)
alias dlogs='sudo docker logs -tf --tail="50" ' # usage: dlogs container_name
alias dlogsize='sudo du -ch $(sudo docker inspect --format='{{.LogPath}}' $(sudo docker ps -qa)) | sort -h' # see the size of docker containers
alias dips="sudo docker ps -q | xargs -n 1 sudo docker inspect -f '{{.Name}}%tab%{{range .NetworkSettings.Networks}}{{.IPAddress}}%tab%{{end}}' | sed 's#%tab%#\t#g' | sed 's#/##g' | sort | column -t -N NAME,IP\(s\) -o $'\t'"

alias dp600='sudo chown -R root:root $HOME/docker/secrets ; sudo chmod -R 600 $HOME/docker/secrets ; sudo chown -R root:root $HOME/docker/.env ; sudo chmod -R 600 $HOME/docker/.env' # re-lock permissions
alias dp777='sudo chown -R $USER:$USER $HOME/docker/secrets ; sudo chmod -R 777 $HOME/docker/secrets ; sudo chown -R $USER:$USER $HOME/docker/.env ; sudo chmod -R 777 $HOME/docker/.env' # open permissions for editing

alias dclogs='dcrun logs -tf --tail="50" ' # usage: dclogs container_name
alias dcup='dcrun up -d --build --remove-orphans' # up the stack
alias dcdown='dcrun down --remove-orphans' # down the stack
alias dcrec='dcrun up -d --force-recreate --remove-orphans' # usage: dcrec container_name
alias dcstop='dcrun stop' # usage: dcstop container_name
alias dcrestart='dcrun restart ' # usage: dcrestart container_name
alias dcstart='dcrun start ' # usage: dcstart container_name
alias dcpull='dcrun pull' # usage: dcpull to pull all new images or dcpull container_name
alias traefiklogs='tail -f $HOME/docker/logs/traefik/traefik.log' # tail traefik logs

#FRIGATE
alias frigatereset='dcdown && frigatebackupconfig && frigatedeldata && frigaterestoreconfig && frigatedelclips && dcup'
alias frigatebackupconfig='sudo cp $HOME/docker/appdata/frigate/config.yaml $HOME/docker/config.yaml'
alias frigaterestoreconfig='sudo cp $HOME/docker/config.yaml $HOME/docker/appdata/frigate/config.yaml'
alias frigatedelclips='sudo rm -r /shared/clips/'
alias frigatedeldata='sudo rm $HOME/docker/appdata/frigate/*'

# NEXTCLOUD
alias ncconfig='sudo docker run -it --rm --volume nextcloud_aio_nextcloud:/var/www/html:rw alpine sh -c "apk add --no-cache nano && nano /var/www/html/config/config.php"'
alias ncocc='sudo docker exec --user www-data -it nextcloud-aio-nextcloud php occ'
alias ncscan='ncocc files:scan --all'

# CROWDSEC
alias cscli='dcrun exec -t crowdsec cscli'
alias csdecisions='cscli decisions list'
alias csalerts='cscli alerts list'
alias csinspect='cscli alerts inspect -d'
alias cshubs='cscli hub list'
alias csparsers='cscli parsers list'
alias cscollections='cscli collections list'
alias cshubupdate='cscli hub update'
alias cshubupgrade='cscli hub update'
alias csmetrics='cscli metrics'
alias csmachines='cscli machines list'
alias csbouncers='cscli bouncers list'
alias csfbstatus='sudo systemctl status crowdsec-firewall-bouncer.service'
alias csfbstart='sudo systemctl start crowdsec-firewall-bouncer.service'
alias csfbstop='sudo systemctl stop crowdsec-firewall-bouncer.service'
alias csfbrestart='sudo systemctl restart crowdsec-firewall-bouncer.service'
alias tailkern='sudo tail -f /var/log/kern.log'
alias tailauth='sudo tail -f /var/log/auth.log'
alias tailcsfb='sudo tail -f /var/log/crowdsec-firewall-bouncer.log'
alias csbrestart='dcrec2 traefik-bouncer ; csfbrestart'

# NAVIGATION
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# SEARCH AND FIND
alias gh='history|grep' # search bash history
alias findr='sudo find / -name'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# FILE SIZE AND STORAGE
alias fdisk='sudo fdisk -l'
alias uuid='sudo vol_id -u'
alias ls='ls -F --color=auto --group-directories-first'
alias ll='ls -alh --color=auto --group-directories-first'
alias lt='ls --human-readable --color=auto --size -1 -S --classify' # file size sorted
alias lsr='ls --color=auto -t -1' # recently modified
alias mnt='mount | grep -E ^/dev | column -t' # show mounted drives
alias dirsize='sudo du -hx --max-depth=1'
alias dirusage='du -ch | grep total' # Grabs the disk usage in the current directory
alias diskusage='df -hl --total | grep total' # Gets the total disk usage on your machine
alias partusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs' # Shows the individual partition usages without the temporary memory values
alias usage10='du -hsx * | sort -rh | head -10' # Gives you what is using the most space. Both directories and files. Varies on current directory

# BASH ALIASES
alias baupdate='curl -s https://raw.githubusercontent.com/rikman122/shared-resources/refs/heads/main/.bash_aliases -o /$HOME/.bash_aliases >/dev/null 2>&1 && . ~/.bashrc'
alias baget='curl -s https://raw.githubusercontent.com/rikman122/shared-resources/refs/heads/main/.bash_aliases -o /$HOME/.bash_aliases >/dev/null 2>&1'

# SYSTEMD START, STOP AND RESTART
alias ctlreload='sudo systemctl daemon-reload'
alias ctlstart='sudo systemctl start'
alias ctlstop='sudo systemctl stop'
alias ctlrestart='sudo systemctl restart'
alias ctlstatus='sudo systemctl status'
alias ctlenable='sudo systemctl enable'
alias ctldisable='sudo systemctl disable'
alias ctlactive='sudo systemctl is-active'

# INSTALLATION AND UPGRADE
alias update='sudo apt-get update'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt-get install'
alias finstall='sudo apt-get -f install'
alias rinstall='sudo apt-get -f install --reinstall'
alias uninstall='sudo apt-get remove'
alias search='sudo apt-cache search'
alias addkey='sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com'

# CLEANING
alias clean='sudo apt-get clean && sudo apt-get autoclean'
alias remove='sudo apt-get remove && sudo apt-get autoremove'
alias purge='sudo apt-get purge'
alias deborphan='sudo deborphan | xargs sudo apt-get -y remove --purge'
alias cleanall='clean && remove && deborphan && purge'

# SHUTDOWN AND RESTART
alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'

# NETWORKING
alias portsused='sudo netstat -tulpn | grep LISTEN'
alias showports='netstat -lnptu'
alias showlistening='lsof -i -n | egrep "COMMAND|LISTEN"'
alias ping='ping -c 5'
alias ipe='curl ipinfo.io/ip' # external ip
alias ipi='ipconfig getifaddr en0' # internal ip
alias header='curl -I' # get web server headers 

# SYSTEM MONITORING
alias meminfo='free -m -l -t' # memory usage
alias psmem='ps auxf | sort -nr -k 4' # get top process eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10' # get top process eating memory
alias pscpu='ps auxf | sort -nr -k 3' # get top process eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10' # get top process eating cpu
alias cpuinfo='lscpu' # Get server cpu info
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log' # get GPU ram on desktop / laptop
alias free='free -h'
