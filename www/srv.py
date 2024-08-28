from flask import Flask, request, render_template, jsonify
from datetime import datetime, timezone
import requests
from waitress import serve
import os

from werkzeug.middleware.proxy_fix import ProxyFix

app=Flask(__name__)

app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)

WDIR=app.root_path

B_0=0.12159533073929651
B_1=3.258360036621652

def p(a):
    return(int(round(B_1*a+B_0, 0)))

def log_request(request):
    with open(os.path.join(WDIR, 'request.log'), 'a') as log:
        unix_timestamp =datetime.timestamp(datetime.now())*1000
        print(unix_timestamp, p(list(request.data)[26]), file=log)

@app.route("/plotly-latest.min.js")
def plotly():
    try:
        with open(os.path.join(WDIR, "templates/plotly-latest.min.js"),"r") as f:
            return f.read()
    except:
        return "error"

@app.route('/api/<start>/<end>', methods=['GET'])
def api(start, end):
    try:
        with open(os.path.join(WDIR, 'request.log'), 'r') as f:
            lines = f.readlines()
        data=[l.split(" ") for l in lines] # timestamp, power
        data={int(float(d[0])): int(d[1]) for d in data if int(float(d[0])) in range(int(start), int(end))}
        return(jsonify(data))
    except Exception as e:
        print(e)
        return "error"

@app.route('/', methods=['GET'])
def data_view():
    return render_template('index.html')

@app.route('/i.php', methods=['GET', 'POST'])
def i():
    try:
        log_request(request)
        current_datetime = datetime.now()
        current_datetime_utc = current_datetime.astimezone(timezone.utc)
        formatted_datetime = current_datetime_utc.strftime('%Y%m%d%H%M%S')
        return str(formatted_datetime)
    except Exception as e:
        print(e)
        return "error"

if __name__ == '__main__':
    os.chdir("/var/www/")
    serve(app, host='0.0.0.0', port=8080)
