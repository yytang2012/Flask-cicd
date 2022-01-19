######################################
# Application Factory Function       #
######################################
from datetime import datetime

from flask import Flask
from flask_cors import CORS

from project.common.settings import VERSION


def create_app(config_filename=None):
    app = Flask(__name__, instance_relative_config=True)
    if config_filename is not None:
        app.config.from_pyfile(config_filename)
    CORS(app)

    @app.route('/')
    def get_current_time():
        res = {
            "Service": "Flask Test",
            "Version": VERSION,
            "Current time": datetime.now().isoformat()
        }
        return res

    return app


