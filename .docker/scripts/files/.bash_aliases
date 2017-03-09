alias edita="joe ~/.bash_aliases ; source ~/.bash_aliases"
alias showa="cat ~/.bash_aliases"
alias c="php bin/console"
alias apare="sudo -u root /etc/init.d/apache2 restart"

alias debugon="sudo -u root ln -s ../../mods-available/xdebug.ini /etc/php5/apache2/conf.d/20-xdebug.ini ; sudo -u root ln -s ../../mods-available/xdebug.ini /etc/php5/cli/conf.d/20-xdebug.ini ; apare ; export XDEBUG_CONFIG=\"idekey=PHPSTORM\" ; export PHP_IDE_CONFIG=\"serverName=docker-vm\""
alias debugoff="sudo -u root rm -f /etc/php5/apache2/conf.d/20-xdebug.ini ; sudo -u root rm -f /etc/php5/cli/conf.d/20-xdebug.ini ; apare"

alias cc="[ -f "shopware.php" ] && c sw:cache:clear || c cache:clear fi"
alias ccc="rm -rf var/cache/production_* ; c sw:cache:clear"
