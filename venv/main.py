from flask import Flask, render_template, session, request, redirect, url_for
from flaskext.mysql import MySQL
from werkzeug.utils import secure_filename
import hashlib
import hashlib_additional
import pandas as pd
import re
from dateutil import parser
from datetime import  datetime

app = Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'dbproject'
app.config['MYSQL_DATABASE_HOST'] = '127.0.0.1'
mysql.init_app(app)


app.secret_key = 'random string'
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = set(['jpeg', 'jpg', 'png', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER



@app.route("/")
def root():
    loggedIn, firstName, noOfItems = getLoginDetails()
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute('SELECT productId, pname, price, description, image, stock FROM products WHERE productId between 2 and 15')
    itemData = cur.fetchall()
    cur.execute('SELECT categoryId, cname FROM categories')
    categoryData = cur.fetchall()
    itemData = parse(itemData)
    return render_template('home.html', itemData=itemData, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems, categoryData=categoryData)



@app.route("/loginForm")
def loginForm():
    if 'email' in session:
        return redirect(url_for('root'))
    else:
        return render_template('login.html', error='')
#Mathew
@app.route("/admin")
def adminloginForm():
        return render_template('adminlogin.html', error='')

#User Login
@app.route("/login", methods=['GET', 'POST'])
def login():

    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        conn = mysql.connect()
        cur = conn.cursor()
        #cur.execute("SELECT * FROM users where email=%e", [email])
        #data = cur.fetchone()
        #return render_template('home.html', data=data)

        if is_valid(email, password):
            session['email'] = email
            return redirect(url_for('root'))
        else:
            error = 'Invalid User email / Password'
            return render_template('login.html', error=error)
#mathew
#Admin Login
@app.route("/adminlogin", methods=['GET', 'POST'])
def adminlogin():

    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        conn = mysql.connect()
        cur = conn.cursor()
        #cur.execute("SELECT * FROM users where email=%e", [email])
        #data = cur.fetchone()
        #return render_template('home.html', data=data)

        if is_validadmin(email, password):
            session['email'] = email
            return render_template('admin.html')
        else:
            error = 'Invalid User email / Password'
            return render_template('login.html', error=error)
#mathew
@app.route("/userstats")
def stats():
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute("SELECT date FROM users")
    data = cur.fetchall()
    data = re.findall(r"'(.*?)'", str(data))
    print(data)
    conn.close()
    return render_template("userstats.html", data=data)

#mathew
@app.route("/loworders")
def order():
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute("SELECT * FROM orders")
    data = cur.fetchall()
    conn.close()
    return render_template("loworder.html", data=data)

def getLoginDetails():
    conn = mysql.connect()
    cur = conn.cursor()
    if 'email' not in session:
            loggedIn = False
            firstName = ''
            noOfItems = 0
    else:
            loggedIn = True
            cur.execute("SELECT userId, firstName FROM users WHERE email = %s", (session['email'], ))
            userId, firstName = cur.fetchone()
            cur.execute("SELECT count(productId) FROM cart WHERE userId = %s", (userId, ))
            noOfItems = cur.fetchone()[0]
    conn.close()
    return (loggedIn, firstName, noOfItems)



@app.route("/logout")
def logout():
    session.pop('email', None)
    return redirect(url_for('root'))



@app.route("/register", methods = ['GET', 'POST'])
def register():
    if request.method == 'POST':
        #Parse form data
        password = request.form['password']
        email = request.form['email']
        firstName = request.form['firstName']
        lastName = request.form['lastName']
        address1 = request.form['address1']
        address2 = request.form['address2']
        zipcode = request.form['zipcode']
        city = request.form['city']
        state = request.form['state']
        country = request.form['country']
        phone = request.form['phone']
        #date = request.form['date']
        conn = mysql.connect()
        cur = conn.cursor()
        try:
            print("Debug register")
            cur = conn.cursor()
            date = pd.to_datetime('today').strftime('%d-%m-%Y')
            cur.execute('INSERT INTO users '
                            '(password, email, firstName, lastName, address1, address2, zipcode, city, state, country, phone, date) '
                            'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',
                            (password,
                             email, firstName, lastName, address1, address2, zipcode, city, state, country, phone, date))
            conn.commit()
            msg = "Registered Successfully"

        except:
            conn.rollback()
            msg = "Error occured"
            conn.close()
        return render_template("login.html", error=msg)



@app.route("/registerationForm")
def registrationForm():
    return render_template("register.html")



@app.route("/add")
def admin():
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute("SELECT categoryId, name FROM categories")
    categories = cur.fetchall()
    conn.close()
    return render_template('add.html', categories=categories)



@app.route("/addItem", methods=["GET", "POST"])
def addItem():
    if request.method == "POST":
        name = request.form['name']
        price = float(request.form['price'])
        description = request.form['description']
        stock = int(request.form['stock'])
        categoryId = int(request.form['category'])

        #Uploading image procedure
        image = request.files['image']
        if image and allowed_file(image.filename):
            filename = secure_filename(image.filename)
            image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        imagename = filename
        conn = mysql.connect()
        try:
            cur = conn.cursor()
            cur.execute('''INSERT INTO products (name, price, description, image, stock, categoryId) VALUES (%s, %s, %s, %s, %s, %s)''',
                        (name, price, description, imagename, stock, categoryId))
            conn.commit()
            msg="added successfully"
        except:
            msg="error occured"
            conn.rollback()
        conn.close()
        print(msg)
        return redirect(url_for('root'))



@app.route("/remove")
def remove():
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute('SELECT productId, name, price, description, image, stock FROM products')
    data = cur.fetchall()
    conn.close()
    return render_template('remove.html', data=data)



@app.route("/removeItem")
def removeItem():
    productId = request.args.get('productId')
    conn = mysql.connect()
    try:
        cur = conn.cursor()
        cur.execute('DELETE FROM products WHERE productID = %s', (productId, ))
        conn.commit()
        msg = "Deleted successsfully"
    except:
        conn.rollback()
        msg = "Error occured"
    conn.close()
    print(msg)
    return redirect(url_for('root'))
#mathew
@app.route("/loworderconfirm")
def confirmstock():
    productId = request.args.get('productId')
    conn = mysql.connect()
    print(productId)
    try:
        cur = conn.cursor()
        cur.execute('UPDATE products SET stock = 50 where productId= %s', (productId, ))
        cur.execute('DELETE FROM ORDERS WHERE productId = %s', (productId, ))
        cur.execute('SELECT * FROM ORDERS')
        data = cur.fetchall()
        conn.commit()
        msg = "Deleted successsfully"
    except:
        conn.rollback()
        msg = "Error occured"
    conn.close()
    print(msg)
    return render_template("loworder.html",data=data)

@app.route("/displayCategory")
def displayCategory():
        loggedIn, firstName, noOfItems = getLoginDetails()
        categoryId = request.args.get("categoryId")
        conn = mysql.connect()
        cur = conn.cursor()
        cur.execute("SELECT products.productId, products.name, products.price, products.image, categories.name FROM products, categories WHERE products.categoryId = categories.categoryId AND categories.categoryId = %s", (categoryId, ))
        data = cur.fetchall()
        conn.close()
        cur.execute('SELECT categoryId, cname FROM categories')
        categoryData = cur.fetchall()
        categoryName = data[0][4]
        data = parse(data)
        return render_template('displayCategory.html', data=data, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems, categoryName=categoryName, categoryData=categoryData)



@app.route("/account/profile")
def profileHome():
    if 'email' not in session:
        return redirect(url_for('root'))
    loggedIn, firstName, noOfItems = getLoginDetails()
    return render_template("profileHome.html", loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems)



@app.route("/account/profile/edit")
def editProfile():
    if 'email' not in session:
        return redirect(url_for('root'))
    loggedIn, firstName, noOfItems = getLoginDetails()
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute("SELECT userId, email, firstName, lastName, address1, address2, zipcode, city, state, country, phone FROM users WHERE email = %s", (session['email'], ))
    profileData = cur.fetchone()
    conn.close()
    return render_template("editProfile.html", profileData=profileData, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems)



@app.route("/account/profile/changePassword", methods=["GET", "POST"])
def changePassword():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    if request.method == "POST":
        oldPassword = request.form['oldpassword']
        oldPassword = hashlib.md5(oldPassword.encode()).hexdigest()
        newPassword = request.form['newpassword']
        newPassword = hashlib.md5(newPassword.encode()).hexdigest()
        conn = mysql.connect()
        cur = conn.cursor()
        cur.execute("SELECT userId, password FROM users WHERE email = %s", (session['email'], ))
        userId, password = cur.fetchone()
        if (password == oldPassword):
            try:
                cur.execute("UPDATE users SET password = %s WHERE userId = %s", (newPassword, userId))
                conn.commit()
                msg="Changed successfully"
            except:
                conn.rollback()
                msg = "Failed"
                return render_template("changePassword.html", msg=msg)
            else:
                msg = "Wrong password"
        conn.close()
        return render_template("changePassword.html", msg=msg)
    else:
        return render_template("changePassword.html")



@app.route("/updateProfile", methods=["GET", "POST"])
def updateProfile():
    if request.method == 'POST':
        email = request.form['email']
        firstName = request.form['firstName']
        lastName = request.form['lastName']
        address1 = request.form['address1']
        address2 = request.form['address2']
        zipcode = request.form['zipcode']
        city = request.form['city']
        state = request.form['state']
        country = request.form['country']
        phone = request.form['phone']
        conn = mysql.connect()
        try:
            cur = conn.cursor()
            cur.execute('UPDATE users SET firstName = %s, lastName = %s, address1 = %s, address2 = %s, zipcode = %s, city = %s, state = %s, country = %s, phone = %s WHERE email = %s', (firstName, lastName, address1, address2, zipcode, city, state, country, phone, email))

            conn.commit()
            msg = "Saved Successfully"
        except:
            conn.rollback()
            msg = "Error occured"
        conn.close()
    return redirect(url_for('editProfile'))



@app.route("/productDescription")
def productDescription():
    loggedIn, firstName, noOfItems = getLoginDetails()
    productId = request.args.get('productId')
    #productId = 2
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute('SELECT categoryId, cname FROM categories')
    categoryData = cur.fetchall()
    print(productId)
    cur.execute("SELECT productId, pname, price, description, image, stock FROM products WHERE productId = %s", (productId,))
    #cur.execute("SELECT productId, pname, price, description, image, stock FROM products WHERE productId = %s",(productId),)

    print("Done")
    productData = cur.fetchone()
    conn.close()
    return render_template("productDescription.html", data=productData, loggedIn = loggedIn, firstName = firstName, noOfItems = noOfItems, categoryData =categoryData)



@app.route("/addToCart")
def addToCart():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    else:
        productId = int(request.args.get('productId'))
        conn = mysql.connect()
        cur = conn.cursor()
        cur.execute("SELECT userId FROM users WHERE email = %s", (session['email'], ))
        userId = cur.fetchone()[0]
        try:
            cur.execute("INSERT INTO cart (userId, productId) VALUES (%s, %s)", (userId, productId))
            conn.commit()
            msg = "Added successfully"
        except:
            conn.rollback()
            msg = "Error occured"
    conn.close()
    return redirect(url_for('root'))



@app.route("/cart")
def cart():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    loggedIn, firstName, noOfItems = getLoginDetails()
    email = session['email']
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute("SELECT userId FROM users WHERE email = %s", (email, ))
    userId = cur.fetchone()[0]
    cur.execute("SELECT products.productId, products.pname, products.price, products.image FROM products, cart WHERE products.productId = cart.productId AND cart.userId = %s", (userId, ))
    products = cur.fetchall()
    totalPrice = 0
    for row in products:
        totalPrice += row[2]
    return render_template("cart.html", products=products, totalPrice=totalPrice, loggedIn=loggedIn, firstName=firstName, noOfItems=noOfItems)



@app.route("/removeFromCart")
def removeFromCart():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    email = session['email']
    productId = int(request.args.get('productId'))
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute("SELECT userId FROM users WHERE email = %s", (email, ))
    userId = cur.fetchone()[0]
    try:
        cur.execute("DELETE FROM cart WHERE userId = %s AND productId = %s", (userId, productId))
        conn.commit()
        msg = "removed successfully"
    except:
        conn.rollback()
        msg = "error occured"
    conn.close()
    return redirect(url_for('root'))



def is_valid(email, password):
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute('SELECT email, password FROM users')
    data = cur.fetchall()
    for row in data:
        if row[0] == email and row[1] == password:
            return True
    return False

def is_validadmin(email, password):
    conn = mysql.connect()
    cur = conn.cursor()
    cur.execute('SELECT email, password FROM admin')
    data = cur.fetchall()
    for row in data:
        if row[0] == email and row[1] == password:
            return True
    return False


def allowed_file(filename):
    return '.' in filename and \
            filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS



def parse(data):
    ans = []
    i = 0
    while i < len(data):
        curr = []
        for j in range(7):
            if i >= len(data):
                break
            curr.append(data[i])
            i += 1
        ans.append(curr)
    return ans



if __name__ == "__main__":
    app.run(debug=True)