# iRODS 4.3.x Server

**Not for use in production!**

This is a Docker image of a vanilla iRODS 4.3.x server that works out
of the box. To be used for running tests only.

The iRODS server starts with a single user 'irods' configured.

## Using the container
### Running

To run the container (with iCAT port binding to the host machine):

`docker run -d --name irods -p 1247:1247 wtsi-npg/ub-18.04-irods-[VERSION]:latest`

where [VERSION] is the required release e.g. 4.3.0

### Connecting
The following iRODS users have been setup:

    | Username | Password | Zone     | Admin |
    | -------- | -------- | -------- | ----- |
    | irods    | irods    | testZone | Yes   |


The `irods_environment.json` in `~/.irods` required to connect as the
preconfigured 'irods' user is:

    {
     "irods_host": "localhost",
     "irods_port": 1247,
     "irods_user_name": "irods",
     "irods_zone_name": "testZone",
     "irods_plugins_home": <path to iRODS plugins>,
     "irods_default_resource": <resource name>
    }

Two resources are configured; a simple resource named "testResc" and a
replication resource named "replResc" where each data object will be
replicated to two filesystem vaults:

    resource name: testResc
    id: 10018
    zone: testZone
    type: replication
    class: cache
    location: EMPTY_RESC_HOST
    vault: EMPTY_RESC_PATH
    free space: 
    free space time: : Never
    status: 
    info: 
    comment: 
    create time: 01559922677: 2019-06-07.16:51:17
    modify time: 01559922677: 2019-06-07.16:51:17
    children: 
    context: 
    parent: 
    object count: 
    ----
    resource name: unixfs2
    id: 10017
    zone: testZone
    type: unixfilesystem
    class: cache
    location: localhost
    vault: /var/lib/irods/iRODS/Vault2
    free space: 
    free space time: : Never
    status: 
    info: 
    comment: 
    create time: 01559922677: 2019-06-07.16:51:17
    modify time: 01559922678: 2019-06-07.16:51:18
    children: 
    context: 
    parent: 10018
    object count: 
    ----
    resource name: unixfs1
    id: 10016
    zone: testZone
    type: unixfilesystem
    class: cache
    location: localhost
    vault: /var/lib/irods/iRODS/Vault
    free space: 
    free space time: : Never
    status: 
    info: 
    comment: 
    create time: 01559922677: 2019-06-07.16:51:17
    modify time: 01559922678: 2019-06-07.16:51:18
    children: 
    context: 
    parent: 10018
    object count:



## Acknowledgments

This image was influenced by [that created by Colin
Nolan](https://github.com/wtsi-hgi/docker-icat) and also by [WSI
Disposable iRODS](https://github.com/wtsi-npg/disposable-irods)
