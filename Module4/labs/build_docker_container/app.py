from flask import Flask


app = Flask(__name__)
app.json.ensure_ascii = False # disable ASCII encoding

@app.route("/")
def home():
    return "Привет из Flask приложения! Я работаю в Docker! CHECK"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

