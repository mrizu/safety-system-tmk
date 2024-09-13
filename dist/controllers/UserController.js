"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserController = void 0;
const dbClient_1 = __importDefault(require("../db/dbClient"));
class UserController {
    getUsers(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const result = yield dbClient_1.default.query('SELECT * FROM users');
                res.json(result.rows);
            }
            catch (error) {
                res.status(500).json({ error: 'Failed to fetch users' });
            }
        });
    }
    getUserById(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            try {
                const result = yield dbClient_1.default.query('SELECT * FROM users WHERE id = $1', [id]);
                if (result.rows.length === 0) {
                    return res.status(404).json({ error: 'User not found' });
                }
                res.json(result.rows[0]);
            }
            catch (error) {
                res.status(500).json({ error: 'Failed to fetch user' });
            }
        });
    }
}
exports.UserController = UserController;
