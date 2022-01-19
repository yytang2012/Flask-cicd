import logging
import os
import sys
from datetime import datetime
from logging.handlers import RotatingFileHandler

from project.common.settings import LOGGER_LEVEL, LOGS

timestamp = lambda: datetime.now().strftime('%Y-%m-%d_%H:%M:%S')


def setup_logger(log_name="my_logger", file_name=None, level=LOGGER_LEVEL, log_dir=LOGS):
    level = level.upper() if type(level) is str else level
    my_logger = logging.getLogger(log_name)
    my_logger.setLevel(level)

    formatter = logging.Formatter('%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
    console_handler = logging.StreamHandler(stream=sys.stdout)
    console_handler.setFormatter(formatter)
    my_logger.addHandler(console_handler)

    if file_name is not None:
        # log_dir = os.path.dirname(os.path.abspath(__file__))
        os.makedirs(log_dir, exist_ok=True)
        if file_name.endswith('.txt') or file_name.endswith('.log'):
            file_name = file_name[:4]
        log_file_name = "{}-{}.txt".format(file_name, timestamp())

        log_file_path = os.path.join(log_dir, log_file_name)
        file_handler = RotatingFileHandler(log_file_path, maxBytes=50 * 1024 * 1024, backupCount=20)
        file_handler.setFormatter(formatter)
        my_logger.addHandler(file_handler)

    return my_logger
