/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */


export const user = state => state.user

export const hasBoards = state => {
  return state.boards.length > 0
}

export const personalBoards = state => {
  return state.boards.filter(board => board.teamId === 0)
}

export const teamBoards = state => {
  const teams = []

  state.teams.forEach(team => {
    teams.push({
      id: team.id,
      name: team.name,
      boards: state.boards.filter(board => board.teamId === team.id)
    })
  })

  return teams
}
