# google-colab-ish

## Notes

1. NVIDIA Container Toolkit:

    Make sure you have nvidia-container-toolkit installed on the host system.

1. Docker Compose GPU Support:

    - If you use Docker Compose v2 or newer, you can specify GPU usage via the deploy.resources.reservations.devices as shown above.
    - For older Docker Compose versions, you can set runtime: nvidia or device_requests. See the official docs for details.

## Build and Run

1. Build and Run the container:

    ```bash
    docker compose up --build
    ```
    
1. How to access

    Go to following URL on your browser. Also, use the Token which is displayed when you run the container.

    ```
    http://127.0.0.1:8888/lab?token={token}
    ```

1. Stop the container (if you ran it in the background):

    ```bash
    docker-compose down
    ```
