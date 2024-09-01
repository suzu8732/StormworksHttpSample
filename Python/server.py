from http.server import HTTPServer
from http.server import BaseHTTPRequestHandler
from urllib.parse import urlparse
from urllib.parse import parse_qs
from http import HTTPStatus
import math

PORT = 8080

class SampleRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed = urlparse(self.path)
        params = parse_qs(parsed.query)

        self.send_response(HTTPStatus.OK)
        self.send_header('Content-type', 'text/plain; charset=utf-8')
        self.end_headers()

        if parsed.path == '/hello':
            print('Recieve Hello')
            self.wfile.write('Hello Stormworks HTTP!!'.encode())
        elif parsed.path == '/calc':
            print('Request Calc')
            x1 = float(params['x[]'][0])
            y1 = float(params['y[]'][0])
            x2 = float(params['x[]'][1])
            y2 = float(params['y[]'][1])
            print(f'Pos1 x:{x1} y:{y1} Pos2 x:{x2} y:{y2}')
            distance = calcDistance(x1, y1, x2, y2)
            print(f'Result: {distance}')
            self.wfile.write(str(distance).encode())
        
def calcDistance(x1, y1, x2, y2):
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

def main():
    print('Start Server')
    server = HTTPServer(('localhost', PORT), SampleRequestHandler)
    server.serve_forever()

if __name__ == '__main__':
    main()