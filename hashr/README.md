# Batch script for verifying IOCs using the hashr tool released by CERT-AGID
Requirements for running the batch script:

- The [hashr](https://cert-agid.gov.it/hashr/) tool must be present in the same folder from which the batch script is started.
- The files containing the IoC hashes must be present in the IoC subdirectory of the folder from which the batch script is started.
- The script by default scans the system drive, which is the volume identified by the %SystemDrive% environment variable.
- If necessary, you can also start the script by specifying a specific path in which to perform the analysis.

Below is an example of how to start the script specifying to run the analysis in the current path:
'CALL Run-hashr.cmd "%cd%"'
