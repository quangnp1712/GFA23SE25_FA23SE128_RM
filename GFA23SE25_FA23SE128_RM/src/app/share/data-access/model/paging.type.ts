export type Paging<T> = {
  total: number;
  pageSize: number;
  current: number;
  content: T[];
};
