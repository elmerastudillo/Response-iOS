import pyrebase

# Configuration dictionary
config = {
	"apiKey": "apiKey",
	"authDomain": "projectId.firebaseapp.com",
	"databaseURL": "https://response-7f7ef.firebaseio.com",
	"storageBucket": "gs://response-7f7ef.appspot.com"
}

firebase = pyrebase.initialize_app(config)

# PATHS
organizations_path = firebase.database().child("/organizations")
missions_path = firebase.database().child("/missions")
causes_path = firebase.database().child("/causes")

# MODELS
organizations_model	= {
	"name": "Unicef", 
	"orgCode": "UCF", 
	"logoImageURL" : "www.image.com",
	"thumbnailImageURL" : "www.thumbnail.com",
	"location" : "New York",
	"videoURL" : "www.videoURL.com",
	"mission" : "This is the mission",
	"slogan" : "THis is the slogan", 
	"color" : "Black", 
	"followers" : 100 
}

cause_model = {
	"name": "Unicef", 
	"charityShortName": "UCF", 
	"image" : "www.image.com",
	"location" : "New York", 
	"videoURL" : "www.videoURL.com",
	"shortDescription" : "This is the mission", 
	"description" : "THis is the slogan", 
	"responses" : 100, 
	"dateStarted" : "Monday, 1"
}

mission_model = {
	"name": "Fighting Famine in Somalia", 
	"orgCode": "UCF", 
	"logoImageURL" : "https://donate.unicef.org/sites/default/files/styles/1200x800/public/donation-campaign/donate/Hurricane-Matthew_form3_0.jpeg?itok=FE-EddfY",
	"thumbnailImageURL" : "https://donate.unicef.org/sites/default/files/styles/1200x800/public/donation-campaign/donate/Hurricane-Matthew_form3_0.jpeg?itok=FE-EddfY",
	"location" : "New York", 
	"videoURL" : "www.videoURL.com",
	"mission" : "This is the mission", 
	"slogan" : "THis is the slogan", 
	"color" : "Black", "followers" : 100, 
	"responses" : 3000, 
	"category" : {"development" : True}
}

def pushToFirebase(path, dictionary):
	# Push with unique key
	path.push(dictionary)

if __name__ == '__main__':
	pushToFirebase(missions_path, mission_model)

