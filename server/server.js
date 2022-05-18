// Imports
const dotenv = require('dotenv');
dotenv.config();
// Express
const express = require("express");
const server = express();
// Middlewares
const bp = require("body-parser");
// JWT
const jwt = require("jsonwebtoken");
const signature = require("./jwt");
// DB setup/connection
const { conf_db_host, conf_db_name, conf_user, conf_password, conf_port } = require("../database/db_connection_data");
const Sequelize = require("sequelize");
const { QueryTypes } = require("sequelize");
const sequelize = new Sequelize(`mysql://${conf_user}:${conf_password}@${conf_db_host}:${conf_port}/${conf_db_name}`);
// Custom Modules
const utils = require("./utils");

// Server Setup
server.use(bp.json());
server.listen("3000", () => {
	const date = new Date();
	console.log(`Clinfec - Server Started ${date}`);
});

// USERS
server.get("/v1/users/login", async (req, res, next) => {
	const { username, email, password } = req.body;
	try {
		const found_username = await get_by_param("users", "username", username);
		const found_email = await get_by_param("users", "email", email);
		if (found_username.is_disabled || found_email.is_disabled) {
			res.status(401).json("Invalid request, user account is disabled");
		} else if (found_username.password === password) {
			const token = generate_token({
				username: found_username.username,
				user_id: found_username.user_id,
				is_admin: found_username.is_admin,
				isDisabled: found_username.is_disabled,
			});
			res.status(200).json(token);
		} else if (found_email.password === password) {
			const token = generate_token({
				username: found_email.username,
				user_id: found_email.user_id,
				is_admin: found_email.is_admin,
				is_disabled: found_email.is_disabled,
			});
			res.status(200).json(token);
		} else {
			res.status(400).json("Invalid username/password supplied");
		}
	} catch (error) {
		next(new Error(error));
	}
});

server.get("/v1/paciente", validate_token, async (req, res, next) => {
	const pacientes = await get_by_param("pacienteclinfec", "ativo", true, true);
	res.status(200).json(pacientes);
});

server.get("/v1/medicos", validate_token, async (req, res, next) => {
	const medicos = await get_by_param("medicoclinfec", "ativo", true, true);
	res.status(200).json(medicos);
});

server.get("/v1/consulta", validate_token, async (req, res, next) => {
	const consultas = await get_by_param("consultaclinfec", "ativo", true, true);
	res.status(200).json(consultas);
});

server.post("/v1/users", async (req, res, next) => {
	const { username, password, email, delivery_address, full_name, phone } = req.body;
	try {
		const existing_username = await get_by_param("users", "username", username);
		const existing_email = await get_by_param("users", "email", email);
		if (existing_username) {
			res.status(409).json("Username already exists, please pick another");
			return;
		}
		if (existing_email) {
			res.status(409).json("Email already exists, please pick another");
			return;
		}
		if (username && password && email && delivery_address && full_name && phone) {
			const insert = await sequelize.query(
				"INSERT INTO users (username, password, full_name, email, phone, delivery_address) VALUES (:username, :password, :full_name, :email, :phone, :delivery_address)",
				{ replacements: { username, password, full_name, email, phone, delivery_address } }
			);
			res.status(200).json("User correctly added to database");
		} else {
			res.status(400).json("Error validating input data");
		}
	} catch (error) {
		console.log(error);
		next(new Error(error));
	}
});

server.delete("/v1/users", validate_token, async (req, res, next) => {
	const token = req.token_info;
	const user_id = token.user_id;
	try {
		const update = await sequelize.query("UPDATE users SET is_disabled = true WHERE user_id = :user_id", {
			replacements: {
				user_id,
			},
		});
		res.status(200).json("User account disabled");
	} catch (error) {
		next(new Error(error));
	}
});

// Test Endpoints
server.get("/v1/validate-token", validate_token, async (req, res, next) => {
	res.status(200).json("Valid Token, carry on");
});

// Functions & Middlewares
function generate_token(info) {
	return jwt.sign(info, signature, { expiresIn: "1h" });
}
async function validate_token(req, res, next) {
	const token = req.headers.authorization.split(" ")[1];
	try {
		const verification = jwt.verify(token, signature);
		const found_user = await get_by_param("users", "user_id", verification.id);
		const isDisabled = !!found_user.is_disabled;
		if (isDisabled) {
			res.status(401).json("Unauthorized - User account is disabled");
		} else {
			req.token_info = verification;
			next();
		}
	} catch (e) {
		console.log(e)
		res.status(401).json("Unauthorized - Invalid Token");
	}
}

async function get_by_param(table, tableParam = "TRUE", inputParam = "TRUE", all = false) {
	const searchResults = await sequelize.query(`SELECT * FROM ${table} WHERE ${tableParam} = :replacementParam`, {
		replacements: { replacementParam: inputParam },
		type: QueryTypes.SELECT,
	});
	return !!searchResults.length ? (all ? searchResults : searchResults[0]) : false;
}

// Generic error detection
server.use((err, req, res, next) => {
	if (!err) return next();
	console.log("An error has occurred", err);
	res.status(500).json(err.message);
	throw err;
});
