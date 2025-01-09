import LikeButton from './like-button';
 
// Function to process text (must be defined before use in JSX)
function createText(text) {
  if (text) {
    return text;
  } else {
    return 'no text here';
  }
}

function Header(props) {
  console.log(props);
  // Function is like Lego components
  return <h1>{`I am doing ${props.title} and I feel ${createText('this is hard')}`}</h1>;
}

// help Next.js distinguish which component to render as the main component of the page.
export default function HomePage() {
  // Pass a title prop to the Header component
  // The HomePage component serves as the parent or layout component,
  // responsible for assembling its children (like Header)
  // and passing them the data they need (via props).

  // Iterate through lists
  const names = ['Ada Lovelace', 'Grace Hopper', 'Margaret Hamilton'];

  return (
    <div>
      <Header title="React" />
      <ul>
        {names.map((name) => (
          <li key={name}>{name}</li>
        ))}
      </ul>
      <LikeButton />
    </div>
  );
}

// AboutPage demonstrates reusability of Header component
function AboutPage() {
  return (
    <div>
      <Header title="About Us" />
    </div>
  );
}

