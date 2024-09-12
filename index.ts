import express from 'express';
import { AppDataSource } from './src/db/data-source';
import userRoutes from './src/routes/userRoutes';

const app = express();
const PORT = 3000;

AppDataSource.initialize()
    .then(() => {
        console.log('Database connected successfully');
        app.use(express.json());

        app.use('/api', userRoutes);

        app.listen(PORT, () => {
            console.log(`Server running on http://localhost:${PORT}`);
        });
    })
    .catch((error) => console.error('Database connection failed:', error));
