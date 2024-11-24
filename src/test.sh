# gree user
echo "hello welcome to curlDel"

#!/bin/bash

cat <<'EOF'
            +--------------------+
            |  CurlDel Request   |
            +--------------------+
                   |
                   v
          +-------------------------+
          |    CurlDel response     |
          +-------------------------+
EOF


# functions for get request
getRequest(){
	echo "You choose get request:"

	echo "Enter endpoint for request: "
	read endpoint
	curl $endpoint
}

# post request
postRequest(){
	echo "You chose post request"
	echo "Enter endpoint for request: "
	read endpoint
	echo "Enter json data for request"
	read jsonData
	curl -X POST $endpoint -d "$jsonData" -H "Content-Type: application/json"
}

updateRequest(){
	echo "You chose update request"
	echo "Enter endpoint for request: "
	read endpoint
	echo "Enter json data for request"
	read jsonData
	curl -X PUT $endpoint -d $jsonData -H "Content-Type: application/json"
}

deleteRequest(){
	echo "You chose delete request"
	echo "Enter endpoint for request: "
	read endpoint
	echo "Enter json data for request"
	read jsonData
	curl -X DELETE $endpoint -H "Content-Type: application/json"
}


# allow user to enter operation number
echo "1.GET 2. POST 3. DELETE 4. UPDATE(PATCH) 5. EXIT"
echo "choose operation number from 1-4: "
read operation

case $operation in 
	1)
	echo "You choose: $operation GET REQUEST"
	getRequest
	;;
	2)
	echo "You choose: $operation POST REQUEST"
	postRequest
	;;
	3)
	echo "You choose: $operation DELETE REQUEST"
	;;
	4)
	echo "You choose: $operation UPDATE REQUEST"
	;;
	5)
	echo "exiting...."
	exit
	;;
	*)
	echo "Invalid option."
	;;
esac