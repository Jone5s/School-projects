const pool = require('../db/pool');
const { describe, expect, test, beforeAll, afterAll } = require('@jest/globals');
const supertest = require('supertest');
const app = require('../app');

const createUserAndGetToken = async () => {
  // Delete any ads associated with the user to prevent foreign key constraint errors.
  await pool.query('DELETE FROM ads WHERE creatorId = (SELECT id FROM users WHERE email=?)', ['testuser@example.com']);
  // Delete the user.
  await pool.query('DELETE FROM users WHERE email=?', ['testuser@example.com']);
  
  const userData = {
    name: 'Test User',
    email: 'testuser@example.com',
    password: 'securepassword123'
  };

  await supertest(app)
    .post('/api/users/signup')
    .send(userData);
  const loginResponse = await supertest(app)
    .post('/api/users/login')
    .send({
      email: userData.email,
      password: userData.password
    });
  return loginResponse.body.token;
};

describe('GET ads endpoint', () => {
  let token;

  beforeAll(async () => {
    token = await createUserAndGetToken();
  });

  test('should return 200 and valid JSON', async () => {
    const response = await supertest(app)
      .get('/api/ads')
      .set('Accept', 'application/json')
      .set('Authorization', `Bearer ${token}`);

    expect(response.status).toEqual(200);
    expect(response.headers['content-type']).toMatch(/json/);
  });

  test('should return ad details when a valid ad ID is provided', async () => {
    // Assume there is at least one ad in the database; you would need to ensure this in your setup or seed data
    const response = await supertest(app)
      .get('/api/ads/1')
      .set('Accept', 'application/json')
      .set('Authorization', `Bearer ${token}`);

    expect(response.status).toEqual(200);
    expect(response.headers['content-type']).toMatch(/json/);
    expect(response.body).toHaveProperty('id', 1);
  });

  test('should return 404 for unknown ad', async () => {
    const response = await supertest(app)
      .get('/api/ads/9999')
      .set('Accept', 'application/json')
      .set('Authorization', `Bearer ${token}`);

    expect(response.status).toEqual(404);
    expect(response.headers['content-type']).toMatch(/json/);
    expect(response.body.message).toEqual('Ad not found');
  });
});

describe('POST ads endpoint', () => {
  let token;

  beforeAll(async () => {
    token = await createUserAndGetToken();
  });

  test('should create a new ad', async () => {
    const adData = {
      make: 'Tesla',
      model: 'Model 3',
      image: 'http://example.com/image.png',
      price: 35000,
      description: 'Electric car',
      hp: 258,
      fueltype: 'Electric',
      displacement: 'N/A',
      end_time: '2024-12-25 15:00:00'
    };

    const response = await supertest(app)
      .post('/api/ads')
      .set('Accept', 'application/json')
      .set('Content-Type', 'application/json')
      .set('Authorization', `Bearer ${token}`)
      .send(adData);

    expect(response.status).toEqual(200);
    expect(response.headers['content-type']).toMatch(/json/);
    expect(response.body.message).toEqual('Ad added successfully');
    return response.body.id;  // Assuming ID is returned in the response body
  });

  test('should fail with empty make', async () => {
    const adData = {
      make: '',
      model: 'Mustang'
    };

    const response = await supertest(app)
      .post('/api/ads')
      .set('Accept', 'application/json')
      .set('Content-Type', 'application/json')
      .set('Authorization', `Bearer ${token}`)
      .send(adData);

    expect(response.status).toEqual(400);
    expect(response.body.message).toEqual('"make" is not allowed to be empty');
  });

  test('should fail with no make', async () => {
    const adData = {
      model: 'Mustang'
    };

    const response = await supertest(app)
      .post('/api/ads')
      .set('Accept', 'application/json')
      .set('Content-Type', 'application/json')
      .set('Authorization', `Bearer ${token}`)
      .send(adData);

    expect(response.status).toEqual(400);
    expect(response.body.message).toEqual('"make" is required');
  });
});

describe('PUT and DELETE ads endpoints', () => {
  let token, adId;

  beforeAll(async () => {
    token = await createUserAndGetToken();
    // Create an ad to get an ID
    const adData = {
      make: 'Tesla',
      model: 'Model 3',
      image: 'http://example.com/image.png',
      price: 35000,
      description: 'Electric car',
      hp: 258,
      fueltype: 'Electric',
      displacement: 'N/A',
      end_time: '2024-12-25 15:00:00'
    };

    const postResponse = await supertest(app)
      .post('/api/ads')
      .set('Accept', 'application/json')
      .set('Content-Type', 'application/json')
      .set('Authorization', `Bearer ${token}`)
      .send(adData);
    adId = postResponse.body.id;
  });

  test('should delete the ad if exists', async () => {
    const response = await supertest(app)
      .delete(`/api/ads/${adId}`)
      .set('Accept', 'application/json')
      .set('Authorization', `Bearer ${token}`);

    expect(response.status).toEqual(200);
    expect(response.headers['content-type']).toMatch(/json/);
    expect(response.body.message).toEqual('Ad deleted');
  });
});

afterAll(async () => {
  await pool.end();
});
