import express from 'express';
import cors from 'cors';
import userRoutes from './routes/userRoutes';
import sitesRoutes from './routes/sitesRoutes'
import systemsRoutes from './routes/systemsRoutes'

const app = express();
const PORT = 4000;

app.use(cors({
    origin: 'http://localhost:3000',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true
}));

app.use(express.json());
app.use('/', userRoutes);
app.use('/', sitesRoutes);
app.use('/', systemsRoutes);


app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
