# greet user 
echo "Hello welcome to curlDel"

# create variable to store operation category
help(){
	echo "Enter operation type 1. for GET 2. POST 3. DELETE 4. UPDATE(PATCH)"
}

# get request
getRequest(){
	echo "Enter url for the link"
	read url
	echo curl "URL: $url"
}

# post
postRequest(){
	echo "Enter url(endpoint) for the link"
	read url
	echo "URL: $url"
}

deleteRequest(){
	echo "Enter url(endpoint) for the link"
	read url
	echo curl "URL: $url"
}

getRequest
# prompt user to enter operation type

# switch between the operation choosed by user or invoke function

# allow user to enter url
# $url = "http://localhost:4000/api/v1/animal-feeding/orders/"
# curl $url

# functions: help, exit, method(GET, POST, DELETE, PATCH)

# store url into a variable

# --format