import requests

url = "https://pokemoncard.io/deck/rapid-striker-sglc-semi-gym-leader-challenge-36438"

response = requests.get(url)

# Print the status code and headers
print(f"Status Code: {response.status_code}")
print("Headers:")
for key, value in response.headers.items():
    print(f"{key}: {value}")

# Print the response content
print("\nContent:")
print(response.text)
