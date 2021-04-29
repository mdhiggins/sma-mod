#!/usr/local/sma/venv/bin/python3
#
##############################################################################
### NZBGET POST-PROCESSING SCRIPT                                          ###

# Converts files and passes them to Sonarr for further processing.
#
# NOTE: This script requires Python to be installed on your system.

##############################################################################
### OPTIONS                                                                ###

# Change to full path to MP4 Automator folder. No quotes and a trailing /
#MP4_FOLDER=~/sickbeard_mp4_automator/

# Convert file before passing to destination (True, False)
#SHOULDCONVERT=False

# Category for Couchpotato
#CP_CAT=Couchpotato

# Category for Sonarr
#SONARR_CAT=Sonarr

# Category for Radarr
#RADARR_CAT=Radarr

# Category for Sickbeard
#SICKBEARD_CAT=Sickbeard

# Category for Sickrage
#SICKRAGE_CAT=Sickrage

# Category for bypassing any further processing but still converting
#BYPASS_CAT=Bypass

# Custom output_directory setting
#OUTPUT_DIR=

# Custom path mapping setting
#PATH_MAPPING=

### NZBGET POST-PROCESSING SCRIPT                                          ###
##############################################################################

import sys
import os

path = os.path.join(os.path.split(sys.argv[0])[0], "NZBGetPostProcess.py")
exec(open(path).read())
