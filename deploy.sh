
PROJECT_FOLDER="DNSServerApp"

if [ -z $1 ] && [ -z $2 ]
then

    echo 'Scarico da Github'
    rm -rf $PROJECT_FOLDER
    git clone https://github.com/CarmeloRicci/DNSServerApp.git

    echo 'Avvio di deploy'

    pm2 delete 0
    cd ~/$PROJECT_FOLDER/backend
    npm install
    npm run be:build
    cd ~/$PROJECT_FOLDER/backend
    NODE_ENV=staging pm2 start dist/main.js --name "dnsserverapp" && cd ~/ && pm2 startup > pm2_startup_output &&
    tail -n 1 pm2_startup_output > pm2_startup.sh && chmod a+rwx pm2_startup.sh && ./pm2_startup.sh && pm2 save
    pm2 stop 0
    pm2 start 0 & pm2 logs 0


else

	if [ "$1" = 1 ]
	then

    echo 'Scarico da Github'
    rm -rf $PROJECT_FOLDER
    git clone https://github.com/CarmeloRicci/DNSServerApp.git

	fi

	if [ "$1" = 2 ]
	then

    echo 'Avvio di deploy'

    pm2 delete 0
    cd ~/$PROJECT_FOLDER/backend
    npm install
    npm run be:build
    cd ~/$PROJECT_FOLDER/backend
    NODE_ENV=staging pm2 start dist/main.js --name "dnsserverapp" && cd ~/ && pm2 startup > pm2_startup_output && 
    tail -n 1 pm2_startup_output > pm2_startup.sh && chmod a+rwx pm2_startup.sh && ./pm2_startup.sh && pm2 save
    pm2 stop 0
    pm2 start 0 & pm2 logs 0


	fi
fi



