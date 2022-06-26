/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */
import axios from 'axios'
import errorParser from '@/utils/error-parser'

export default {
  /**
   * Fetch current user's name, boards, and teams
   */
  getMyData () {
    return new Promise((resolve, reject) => {
      axios.get('/me').then(({data}) => {
        resolve(data)
      }).catch((error) => {
        reject(errorParser.parse(error))
      })
    })
  }
}
