export namespace AutocompleteApi {
  export interface Response {
    value: {
      predictions: [
        description: string,
        place_id: string
      ]
    }
  }

}
