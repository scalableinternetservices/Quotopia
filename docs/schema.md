### Database Tables
----------------------------------------
<ul>
    <li>Quote(id: integer, content: text, author_id: integer, user_id: integer, created_at: datetime, updated_at: datetime)</li>
    <li>Comment(id: integer, content: text, quote_id: integer, user_id: integer, created_at: datetime, updated_at: datetime)</li>
    <li>Author(id: integer, name: string, created_at: datetime, updated_at: datetime)</li>
    <li>Category(id: integer, content: string, quote_id: integer, created_at: datetime, updated_at: datetime)</li>
    <li>User(id: integer, email:string, encrypted_password: string, DEVISE_ATTRIBUTES)</li>
    <li>Vote(id: integer, value: integer, user_id: integer, quote_id: integer)</li>
    <li>CategoryQuote(category_id: integer, quote_id: integer)</li>
</ul>