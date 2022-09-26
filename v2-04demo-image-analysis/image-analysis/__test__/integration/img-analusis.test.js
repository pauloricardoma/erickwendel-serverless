const {
  describe,
  test,
  expect
} = require('@jest/globals')

const aws = require('aws-sdk')
aws.config.update({
  region: 'us-east-1'
})

const requestMock = require('./../mocks/request.json')
const {
  main
} = require('../../src')

describe('Image analyser test suite', () => {
  test('it should analyse successfuly the image returning the result', async () => {
    const finalTexts = [
      '99.48% de ser do tipo Cachorro',
      '99.48% de ser do tipo animal de estimação',
      '99.48% de ser do tipo canino',
      '99.48% de ser do tipo animal',
      '99.48% de ser do tipo mamífero',
      '96.48% de ser do tipo pug',
    ].join('\n')
    const expected = {
      statusCode: 200,
      body: `A minha imagem tem\n`.concat(finalTexts)
    }
    const result = await main(requestMock)
    expect(result).toStrictEqual(expected)
  })
  test('given an empty queryString it should return status code 400', async () => {
    const expected = {
      statusCode: 400,
      body: 'an IMG is required!'
    }
    const result = await main({ queryStringParameters: {} })
    expect(result).toStrictEqual(expected)
  })
  test('given invalid ImageURL it should return 500', async () => {
    const expected = {
      statusCode: 500,
      body: 'Internal Server Error!'
    }
    const result = await main({ 
      queryStringParameters: {
        imageUrl: "test"
      } 
    })
    expect(result).toStrictEqual(expected)
  })
})