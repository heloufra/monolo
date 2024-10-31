import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Seeding categories
  const category = await prisma.category.create({
    data: {
      name: 'Pizza',
    },
  });

  // Seeding restaurants
  const restaurant = await prisma.restaurant.create({
    data: {
      name: 'Burger Place',
      address: {
        create: {
          name: 'Main Branch',
          street: '123 Food Street',
          city: 'Foodville',
          country: 'USA',
          latitude: 40.7128,
          longitude: -74.0060,
        },
      },
      email: 'burgerplace@example.com',
      phoneNumber: '1234567890',
      logo: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80',
      pictures: ['https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80'],
      description: 'Best burgers in town!',
      categories: {
        connect: {
          id: category.id,
        },
    },
    },
  });



  // Seeding dishes
  const dish = await prisma.dish.create({
    data: {
      name: 'Cheeseburger',
      description: 'Delicious beef patty with cheese',
      price: 9.99,
      rating: 4.5,
      pictures: ['https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80'],
      restaurant: {
        connect: {
          id: restaurant.id,
        },
      },
      category: {
        connect: {
          id: category.id,
        },
      },
    },
  });

  // Seeding reviews

}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
