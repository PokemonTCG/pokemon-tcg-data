import requests

# Define the API endpoint and authorization token
url = "https://pokemoncard.io/deck/rapid-striker-sglc-semi-gym-leader-challenge-36438"
headers = {
    "Authorization: Bearer 60d9e6634197ad65d5be352b4d98606638bc4440f4fcb099359252999936173d"
}

# Make the API call
response = requests.get(url, headers=headers)

# Check if the request was successful
if response.status_code == 200:
    # Parse the JSON response
    data = response.json()
    
    # Extract and print the contents of the elements
    for key, value in data.items():
        print(f"{key}: {value}")
else:
    print(f"Failed to retrieve data: {response.status_code}")

