import os
from flask import Flask, render_template
from dotenv import load_dotenv
 
load_dotenv()   # reads .env into os.environ
 
app = Flask(__name__)
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev')
 
@app.route('/')
def index():
    return render_template('home.html')
 
@app.route('/students')
def students():
    return render_template('students.html')
 
if __name__ == '__main__':
    debug = os.environ.get('FLASK_DEBUG', '0') == '1'
    app.run(debug=debug)

