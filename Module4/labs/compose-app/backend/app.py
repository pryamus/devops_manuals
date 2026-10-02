from flask import Flask, jsonify, render_template


app = Flask(__name__)
app.json.ensure_ascii = False # disable ASCII encoding

@app.route("/")
def home():
    return render_template("index.html", message="Data from flask application")


@app.route("/user")
def get_user():
    data = {
        "name": "Петр", 
        "surname": "Иванов", 
        "age": 18
    }
    return jsonify(data), 200
    # return "Привет из Flask приложения! Я работаю в Docker! Кодировка UTF-8"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

