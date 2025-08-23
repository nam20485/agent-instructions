export default async function run(ctx) {
  const { args, refs, meta } = ctx;
  const ref = args?.ref;
  const prior = ref ? refs.get(ref) : undefined;
  if (Array.isArray(prior)) {
    return { output: prior, vars: { lastFunction: meta.functionName } };
  }
  // Fallback: empty list to allow loops to proceed; real implementations may fetch from APIs
  return { output: [], vars: { lastFunction: meta.functionName } };
}
