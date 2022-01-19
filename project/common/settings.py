import os
from pathlib import Path

LOCAL_PORT = os.getenv("LOCAL_PORT", "8080")
LOGGER_LEVEL = os.getenv("LOGGER_LEVEL", "DEBUG")

PROJECT = Path(__file__).resolve().parent.parent
ROOT = PROJECT.parent
DATA = ROOT.joinpath("data")
LOGS = ROOT.joinpath("logs")

VERSION = open(ROOT.joinpath("VERSION")).readline().strip(" \n\t")
