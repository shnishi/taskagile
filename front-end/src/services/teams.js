/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */

import axios from 'axios'
import errorParser from '@/utils/error-parser'

export default {
  /**
   * Create a team
   * @param {*} detail the detail of the team
   */
  create (detail) {
    return new Promise((resolve, reject) => {
      axios.post('/teams', detail).then(({data}) => {
        resolve(data)
      }).catch((error) => {
        reject(errorParser.parse(error))
      })
    })
  }
}

