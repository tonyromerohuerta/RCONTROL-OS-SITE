import socket

def communicate_with_satellite(ip, port, command):
    """
    Connects to a satellite and sends a command.
    """
    try:
        # Create a socket with a timeout
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(10)  # Set a 10-second timeout
            s.connect((ip, port))
            print(f"Connected to satellite at {ip}:{port}")
            
            # Send command
            s.sendall(command.encode())
            print(f"Command sent: {command}")
            
            # Receive response
            response = s.recv(1024).decode()
            print(f"Satellite Response: {response}")
            return {
                "success": True,
                "response": response
            }
    
    except socket.timeout:
        print(f"Error: Connection to satellite at {ip}:{port} timed out.")
        return {
            "success": False,
            "error": "Connection timed out"
        }
    
    except Exception as e:
        print(f"Error communicating with satellite: {e}")
        return {
            "success": False,
            "error": str(e)
        }