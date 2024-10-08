# NPG Porch Server

**Not for use in production!**

This is a Docker image hosting both a Porch server and its PostgreSQL database
that works out of the box. To be used for running tests only.

The application is populated with a hard-coded administrator user, password and
administration token and is configured log to STDERR and STDOUT.

## Using the container
### Running

To run the container (with the Porch port published to the host network):

`docker run -d -name porch -p 8081:8081 wsinpg/python-3.10-npg-porch-[VERSION]:latest`

where [VERSION] is the required npg_porch release e.g. 2.0.0

### Connecting

The Porch server is configured to use HTTP on port 8081 and an admin token of

`00000000000000000000000000000000`

has been set in the database. See the Dockerfile for the configuration of the
backend database.
