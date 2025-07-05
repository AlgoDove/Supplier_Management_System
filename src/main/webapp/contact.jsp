<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Inventory Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #00bcd4, #008cba);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .hero {
            text-align: center;
            margin-bottom: 20px;
        }
        .hero i {
            font-size: 50px;
            color: #00bcd4;
            margin-bottom: 20px;
        }
        h1 {
            font-size: 36px;
            font-weight: 500;
            color: #333;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
        }
        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .input-group label {
            font-size: 16px;
            color: #333;
            font-weight: 600;
            margin-bottom: 5px;
            display: block;
        }
        .input-group input, .input-group textarea {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
        }
        .input-group input:focus, .input-group textarea:focus {
            border-color: #00bcd4;
        }
        .button {
            display: inline-block;
            padding: 15px 30px;
            background-color: #00bcd4;
            color: #fff;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }
        .button:hover {
            background-color: #008cba;
        }
        .footer {
            margin-top: 30px;
        }
        .footer a {
            color: #008cba;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }
        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="hero">
        <i class="bi bi-envelope"></i>
        <h1>Contact Us</h1>
    </div>

    <p>If you have any questions or need assistance, feel free to reach out to us. We are happy to help!</p>

    <form action="submit-contact.jsp" method="post">
        <div class="input-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" required placeholder="Your full name">
        </div>
        <div class="input-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required placeholder="Your email address">
        </div>
        <div class="input-group">
            <label for="subject">Subject</label>
            <input type="text" id="subject" name="subject" required placeholder="Subject of your inquiry">
        </div>
        <div class="input-group">
            <label for="message">Message</label>
            <textarea id="message" name="message" rows="5" required placeholder="Your message here"></textarea>
        </div>
        <button type="submit" class="button">Send Message</button>
    </form>

    <div class="footer">
        <p>Go back to <a href="index.jsp">Home</a></p>
    </div>
</div>

</body>
</html>
