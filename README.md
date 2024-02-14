# Brudi Docker Image (with rclone, mariadb, postgres)

This repository provides a Docker image based on Alpine Linux that includes Brudi along with related dependencies such as Restic, Rclone, MariaDB/MySQL, and PostgreSQL binaries.

Docker image: https://hub.docker.com/r/sami/brudi-rclone
Source code: https://github.com/s83/docker-brudi-rclone

## Features

- **Brudi**: A powerful tool for managing your personal data and documents securely.
- **Restic**: Fast, secure, efficient backup program.
- **Rclone**: Command-line program for managing files on cloud storage.
- **MariaDB/MySQL and PostgreSQL Binaries**: Popular relational database management systems.

## Usage

### Pulling the Docker Image

You can pull the latest version of the Docker image from Docker Hub using the following command:

```bash
docker pull sami/brudi-rclone
```

### Running the Container

To run a container with the Brudi image, you can use the following command:

```bash
docker run --it --rm --name brudi-container sami/brudi-rclone -- bash
```

## Contributing

If you find any issues with this Docker image or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
