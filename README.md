# synpop-2-parcels-irtx

## Description

Retrieves the data from population synthesis model and passes them as inputs for the
parcels model.

Since there are no modifications needed the models simply passes through the data to the expected directories.

## Installation

This is a `bash` script so nothing more than a bash shell is needed.

Furthermore, the connector model has been packaged into a alpine linux Docker container.

```
docker build -t synpop-2-parcels-irtx:latest
```

## Usage

Script help message:
```
$ ./entrypoint.sh -h                                                                                                                                                                                          2023-03-06 14:38:55
entrypoint.sh: Moves the data as outputs

Basic usage: entrypoint.sh [-vh] persons-file homes-file output-path

Required arguments:
persons-path             the path of the persons file
homes-path               the path of the homes file
out-dir                  the output directory

Optional arguments:
-v      Sets verbosity level
-h      Shows this message
Examples:
./entrypoint.sh -v ../sample-data/input/persons.csv ../sample-data/input/homes.gpkg ../sample-data/output/
```

### Examples

```
./src/entrypoint.sh -v \
    ./sample-data/input/lead_persons.csv \
    ./sample-data/input/lead_homes.gpkg \
    ./sample-data/output/
```

```
docker run --rm \
    -v $PWD/sample-data:/data \
    synpop-2-parcels-irtx:latest \
    /data/input/lead_persons.csv \
    /data/input/lead_homes.gpkg \
    /data/output
```
