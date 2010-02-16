import sys, getopt, ConfigParser, os
import logging

import pysvn

# Global var to hold the logger
logger = None

## Constants
#  build config file
CONFIG_FILE = 'build.conf'
#  the dir to put the build in - relative to where we use this script
BUILD_DIR = './build'

def loginit():
    """
    Sets up logging for the app.
    """
    global logger
    # create logger
    logger = logging.getLogger("build_log")
    logger.setLevel(logging.DEBUG)

    # create console handler and set level to debug
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)

    # create formatter
    formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")

    # add formatter to ch
    ch.setFormatter(formatter)

    # add ch to logger
    logger.addHandler(ch)
    return logger

def init():
    """
    Set up. Ensures that the following are in place:
    * Checks that the config file is defined
    * svn repository url specified
    * build location specified in the config file
    """
    global logger
    logger.info("init() enter")

    # Config files
    config = ConfigParser.ConfigParser()
    config.read(CONFIG_FILE)
    print config.sections()

    logger.info("init() exit")
    return config

def bootstrap(conf):
    """
    Boostraps the build b doing the following:
    *
    """
    global logger
    logger.info("bootstrap() enter")

    # Fetch the .releases dir that contains releases.csv
    logger.debug("looking for: " + BUILD_DIR)
    if os.path.exists(BUILD_DIR):
        os.mkdir(BUILD_DIR)
        logger.debug("Created:: " + BUILD_DIR)

    repo = conf.get('bootstrap', 'repository', 0)

    client = pysvn.Client()
    path = os.path.join(repo, '.releases')
    print path
    client.checkout(path, BUILD_DIR)

    logger.info("bootstrap() exit")

def list(conf):
    """
    Lists all of the builds contained within releases.csv files.
    """
    global logger
    logger.info("list() enter")
    logger.info("list() exit")

def checkout():
    """
    Checks out the parts of the tree containing code.
    If the repository already exists then this only performs an update
    on the repository.
    """
    global logger
    logger.info("checkout() enter")
    logger.info("checkout() exit")

def validate():
    """
    Validates the repository to ensure that the following are present:
    * That the .releases folder exists and that it contains a releases.csv file
    * That the releases.csv file makes sense
    * That we have the folders required:
        * Releases
        * Sites
    """
    global logger
    logger.info("validate() enter")
    logger.info("validate() exit")

def build(conf):
    """
    Does the build - selects all items that have changed within
    the bounding rebvision numbers specified within a row of the
    releases.csv file
    """
    global logger
    logger.info("build() enter")
    logger.info("build() exit")

def usage():
    """
    Prints out the correct command line usage
    """
    global logger
    logger.info("usage() enter")
    use = """
    build [bootstrap] [list] [rel_name=<Release_Name>]
    """
    print use
    logger.info("usage() exit")

def main():
    """
    Main functoin - handles the command line params and calls the correct functionality
    based on these.
    """
    # Set up logging
    loginit()
    try:
        opts, args = getopt.getopt(sys.argv[1:], "", ["bootstrap", "list", "rel_name="])
    except getopt.GetoptError, err:
        logger.error(str(err))
        usage()
        sys.exit(2)

    # Do things
    try:
        # Perform any initialisation
        conf = init()
        if len(opts) == 0:
            build(conf)
        else:
            for o, a in opts:
                if o == "--bootstrap":
                    bootstrap(conf)
                elif o == "--list":
                    list(conf)
                elif o == "--rel_name":
                    build(conf)
                else:
                    pass
    except Exception, inst:
        logger.error( str(inst))
        print "Build failed"
        sys.exit(2)

if __name__ == "__main__":
    main()
