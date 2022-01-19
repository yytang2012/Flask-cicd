from project import create_app
from project.common.settings import LOCAL_PORT

app = create_app()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=LOCAL_PORT)
